<template>
  <div class="mx-auto max-w-sm">
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.progress') }}</h1>

    <h2 class="sr-only">{{ $t('progressPage.stats') }}</h2>
    <p class="text-2xl text-dft-grey-mid mb-8">
      {{ $t('progressPage.completedText', { count: completedProgs.length }) }}
    </p>

    <p class="text-5xl text-center mb-6">
      <span aria-hidden="true">{{ percentCompleted }}%</span>
      <span class="sr-only">{{ $t('progressPage.completedPercent', { percent: percentCompleted }) }}</span>
    </p>
    <div class="w-full rounded-full border-dft-primary border h-8 mb-24 overflow-hidden">
      <div class="bg-dft-primary h-full rounded-l-full" :class="`w-[${percentCompleted}%]`" />
    </div>

    <h2 class="sr-only">{{ $t('progressPage.calendar') }}</h2>
    <section class="mb-14">
      <div class="flex items-center -ml-4">
        <button @click="goBack" class="min-w-11 min-h-11 flex items-center justify-center"
          :aria-label="$t('labels.calendar.backMonth')" aria-controls="monthInfo" :aria-invalid="previousDatesError"
          :aria-errormessage="previousDatesError ? 'monthInfo' : undefined">
          <BaseIcon icon="arrowLeft" />
        </button>
        <h3 class="text-xl">{{ currentTable.nameString }}, {{ currentTable.year }}</h3>
        <button @click="goForward" class="min-w-11 min-h-11 flex items-center justify-center"
          :aria-label="$t('labels.calendar.forwardMonth')" aria-controls="monthInfo" :aria-invalid="futureDatesError"
          :aria-errormessage="futureDatesError ? 'monthInfo' : undefined">
          <BaseIcon icon="arrowRight" />
        </button>
      </div>

      <!-- Live region for telling SR users  -->
      <div class="min-h-8 text-dft-error" role="region" id="monthInfo" aria-live="polite">
        <p v-if="futureDatesError">{{ $t('labels.calendar.noFutureDates') }}</p>
        <p v-else-if="previousDatesError">{{ $t('labels.calendar.noPreviousDates') }}</p>
        <p v-else class="sr-only">{{ currentTable.nameString }}, {{ currentTable.year }}</p>
      </div>

      <table
        class="text-dft-black rounded-dft-md border-separate border-spacing-2 w-full border border-dft-light-grey bg-dft-white">

        <caption class="sr-only">
          {{ $t('progressPage.tableCaptionMonth', {
            month: currentTable.nameString,
            completecount: currentTable.completedDates.length,
            partiallycompletecount: currentTable.partiallyCompletedDates.length
          })
          }}
        </caption>

        <thead>
          <tr>
            <th scope="col" v-for="i in 7">
              <span aria-hidden="true">{{ $t(`daysOfTheWeek.${i - 1}.abbreviation`) }}</span>
              <span class="sr-only">{{ $t(`daysOfTheWeek.${i - 1}.name`) }}</span>
            </th>
          </tr>
        </thead>

        <tbody>
          <tr v-for="(week, weekIndex) in currentTable.dates" :key="weekIndex">
            <td class="p-2 text-center font-subtle text-sm rounded-dft-sm" v-for="(day, dayIndex) in week"
              :key="dayIndex" :class="cellClasses(day)">
              <span class="sr-only" v-if="day.isSameMonth">
                {{ day.isComplete ? $t('progressPage.statusComplete') : day.isPartiallyComplete ?
                  $t('progressPage.statusPartiallyComplete') : $t('progressPage.statusIncomplete') }}
              </span>
              {{ getDate(day.date) }}
            </td>
          </tr>
        </tbody>
      </table>
    </section>
  </div>
</template>

<script setup lang="ts">
import BaseIcon from "../components/BaseIcon.vue";

import { format, getDate, eachDayOfInterval, eachWeekOfInterval, eachMonthOfInterval, addDays, addMonths, isEqual, getYear, isThisMonth } from "date-fns"

import { computed, ref } from 'vue'
import { useI18n } from 'vue-i18n'

import { Prog, Startdate } from '../types'
const { progs, startdate } = defineProps<{ progs: Prog[], startdate: Startdate }>()

const useFormat = (dateToFormat) => {
  return format(dateToFormat, 'yyyy-MM-dd')
}

const { t } = useI18n() // use as global scope

const completedProgs = progs.filter(prog => prog.completed).map(el => new Date(el.completed_at))
const partiallyCompletedProgs = progs.filter(prog => !prog.completed).map(el => new Date(el.created_at))

const allMonthsStartDates: any[] = eachMonthOfInterval({
  start: new Date(startdate),
  end: new Date()
})

// Track the month we are currently viewing. Defaults to the user's current month.
const currentMonthIndex = ref(allMonthsStartDates.findIndex(el => isThisMonth(el)))

const monthNameTranslation = (monthIndex) => {
  return t(`months.${allMonthsStartDates[monthIndex].getMonth()}`)
}

const isCompletedDay = (dateToCheck) => {
  const completedProgMatch = completedProgs.find(el => {
    return isEqual(useFormat(el), useFormat(new Date(dateToCheck)))
  })

  return !!completedProgMatch
}

const isPartialDay = (dateToCheck) => {
  const partiallyCompletedProgMatch = partiallyCompletedProgs.find(el => {
    return isEqual(useFormat(el), useFormat(new Date(dateToCheck)))
  })

  return !!partiallyCompletedProgMatch
}

const isSameMonth = (dateToCheck, monthToCheck) => {
  const currentMonth = new Date(monthToCheck).getMonth()
  const dateMonth = new Date(dateToCheck).getMonth()

  return currentMonth === dateMonth
}

const getEachWeekOfMonth = (monthStart: string) => {
  return eachWeekOfInterval({
    start: new Date(monthStart),
    end: addMonths(monthStart, 1)
  })
}

const getEachDayOfWeek = (weekStart: any) => {
  const days = eachDayOfInterval({
    start: new Date(weekStart),
    end: addDays(weekStart, 6)
  })

  days.map(day => useFormat(day))

  return days
}

const tables: any[] = []
for (let i = 0; i < allMonthsStartDates.length; i++) {
  // Make a new array in the tables array. Visually this will be one calendar month.
  const monthData: Record<string, any> = {
    nameString: t(`months.${allMonthsStartDates[i].getMonth()}`),
    year: getYear(allMonthsStartDates[i]),
    dates: [],
    completedDates: [],
    partiallyCompletedDates: []
  }

  const currentMonthStartDate = allMonthsStartDates[i]

  // Fill the month with each of the weeks
  const weeksOfMonth = getEachWeekOfMonth(currentMonthStartDate)

  // Fill each week with day objects
  weeksOfMonth.forEach(week => {
    const daysOfWeek = getEachDayOfWeek(new Date(week)).map(day => {
      const dayIsComplete = isCompletedDay(day)
      const dayIsPartiallyComplete = isPartialDay(day)

      const dayIsInSameMonth = isSameMonth(day, currentMonthStartDate)

      if (dayIsComplete && dayIsInSameMonth) monthData.completedDates.push(day)
      if (dayIsPartiallyComplete && dayIsInSameMonth) monthData.partiallyCompletedDates.push(day)

      return {
        date: day,
        isComplete: dayIsComplete,
        isPartiallyComplete: dayIsPartiallyComplete,
        isSameMonth: dayIsInSameMonth
      }
    })

    monthData.dates.push(daysOfWeek)
  })

  tables.push(monthData)
}

const currentTable = computed(() => {
  return tables[currentMonthIndex.value]
})

const cellClasses = (day) => {
  // Dont apply special classes for anything outside the current context
  if (!day.isSameMonth) return 'bg-dft-grey-light'

  if (day.isPartiallyComplete) return 'bg-dft-grey-mid outline outline-dashed outline-black'

  if (day.isComplete) return 'bg-dft-primary outline outline-black'

  return 'bg-dft-grey-mid'
}


const futureDatesError = ref(false)
const previousDatesError = ref(false)

const resetErrors = () => {
  futureDatesError.value = false
  previousDatesError.value = false
}

const goBack = () => {
  resetErrors()

  if (tables[currentMonthIndex.value - 1]) {
    currentMonthIndex.value -= 1
  } else {
    previousDatesError.value = true
  }
}

const goForward = () => {
  resetErrors()

  if (tables[currentMonthIndex.value + 1]) {
    currentMonthIndex.value += 1
  } else {
    futureDatesError.value = true
  }
}

const percentCompleted = Math.round((100 * completedProgs.length) / 182)

// TODO: Can we make an accessible tooltip for each of the days?
// TODO: Make the week view
// TODO: Units!
</script>
