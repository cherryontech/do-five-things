<template>
  <div class="mx-auto max-w-sm">
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.progress') }}</h1>

    <h2 class="mb-16 text-2xl text-center">
      {{ $t('progressPage.completedText', { count: completedProgs.length }) }}
    </h2>

    <p>days checked in: {{ progs.length }}</p>
    <p>completed days: {{ completedProgs.length }}</p>


    <div v-for="(month, monthIndex) in tables" :key="monthIndex">
      <h3>{{ month.nameString }}</h3>

      <table
        class="text-dft-black rounded-dft-md border-separate border-spacing-2 w-full border border-dft-light-grey bg-dft-white">

        <caption class="sr-only">{{ $t('progressPage.tableCaptionMonth', { month: month.nameString, count: month.completedDates.length }) }}</caption>

        <thead>
          <tr>
            <th scope="col" v-for="i in 7">
              <span aria-hidden="true">{{ $t(`daysOfTheWeek.${i-1}.abbreviation`) }}</span>
              <span class="sr-only">{{ $t(`daysOfTheWeek.${i-1}.name`) }}</span>
            </th>
          </tr>
        </thead>

        <tbody>
          <tr v-for="(week, weekIndex) in month.dates" :key="weekIndex">
            <td class="p-2 text-center font-subtle text-sm rounded-dft-sm" v-for="(day, dayIndex) in week"
              :key="dayIndex"
              :class="day.isComplete && day.isSameMonth ? 'bg-dft-primary' : day.isSameMonth ? 'bg-dft-grey-mid' : 'bg-dft-grey-light'">
              <span class="sr-only">
                {{ day.isComplete ? $t('progressPage.statusComplete') : $t('progressPage.statusIncomplete') }}
              </span>
              {{ getDate(day.date) }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { format, getDate, eachDayOfInterval, eachWeekOfInterval, eachMonthOfInterval, addDays, addMonths, isEqual } from "date-fns"

import { useI18n } from 'vue-i18n'

import { Prog, Startdate } from '../types'
const { progs, startdate } = defineProps<{ progs: Prog[], startdate: Startdate }>()

const useFormat = (dateToFormat) => {
  return format(dateToFormat, 'yyyy-MM-dd')
}

const { t } = useI18n() // use as global scope

const completedProgs = progs.filter(prog => prog.completed).map(el => new Date(el.completed_at))

const allMonthsStartDates: any[] = eachMonthOfInterval({
  start: new Date(startdate),
  end: new Date()
})

const monthNameTranslation = (monthIndex) => {
  return t(`months.${allMonthsStartDates[monthIndex].getMonth()}`)
}

const isCompletedDay = (dateToCheck) => {
  const completedProgMatch = completedProgs.find(el => {
    return isEqual(useFormat(el), useFormat(new Date(dateToCheck)))
  })

  return !!completedProgMatch
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
    dates: [],
    completedDates: []
  }

  const currentMonthStartDate = allMonthsStartDates[i]

  // Fill the month with each of the weeks
  const weeksOfMonth = getEachWeekOfMonth(currentMonthStartDate)

  // Fill each week with day objects
  weeksOfMonth.forEach(week => {
    const daysOfWeek = getEachDayOfWeek(new Date(week)).map(day => {
      const dayIsCompleted = isCompletedDay(day)
      const dayIsInSameMonth = isSameMonth(day, currentMonthStartDate)

      if(dayIsCompleted && dayIsInSameMonth) monthData.completedDates.push(day)

      return { 
        date: day, 
        isComplete: dayIsCompleted, 
        isSameMonth: dayIsInSameMonth
 
      }
    })

    monthData.dates.push(daysOfWeek)
  })

  tables.push(monthData)
}



// TODO: Can we make an accessible tooltip here?
// TODO: Make the week view
// TODO: Units!
</script>
