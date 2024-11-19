<template>
  <form @submit.prevent="validateAndSave" class="mx-auto max-w-sm flex flex-col">
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.settings') }}</h1>

    <h2 class="mb-16 text-2xl text-center">{{ $t('flavorText.whatFiveThings') }}</h2>

    <p class="max-w-xs mx-auto p-6 pt-0 mt-5 order-last text-dft-error" id="legend">{{ $t('settingsPage.legend') }}</p>

    <ol class="dft-list-layout">
      <li v-for="(task, index) in tasks" :key="task.id">
        <TaskInput :aria-describedby="`${anyError && !task.text ? 'errorText' : ''} legend`" :taskNumber="index + 1"
          v-model="tasks[index].text" :hasError="anyError && !task.text" />
      </li>
    </ol>

    <div aria-live="assertive" class="order-last mb-7 text-dft-error">
      <p tabindex="-1" v-if="anyError" id="errorText" ref="errorTextRef">{{ $t('settingsPage.errorText') }}</p>
    </div>

    <BaseButton class="order-last my-5 mx-auto block" :hasError="anyError">
      {{ $t('labels.save') }}
    </BaseButton>
  </form>
</template>

<script setup lang="ts">
import BaseButton from '../components/BaseButton.vue'
import TaskInput from '../components/TaskInput.vue';

import { Ref, computed, nextTick, ref } from 'vue'

interface Task {
  id: number,
  text: string
}

const tasks: Ref<Task[]> = ref(
  localStorage.getItem('dftTasks') ?
    JSON.parse(localStorage.getItem('dftTasks')!) :
    [
      { id: 1, order: 1, text: '', completed: false },
      { id: 2, order: 2, text: '', completed: true },
      { id: 3, order: 3, text: '', completed: false },
      { id: 4, order: 4, text: '', completed: false },
      { id: 5, order: 5, text: '', completed: false },
    ]
)

const anyEmpty = computed(() => {
  if (!tasks.value || tasks.value.length === 0) return true

  return tasks.value.some(task => {
    return !Boolean(task.text)
  })
})

const anyError = ref(false)
const errorTextRef: Ref<HTMLElement | null> = ref(null)

const validateAndSave = async () => {
  anyEmpty.value ? anyError.value = true : anyError.value = false

  await nextTick()
  if (anyError.value && errorTextRef.value) errorTextRef.value?.focus()

  localStorage.setItem('dftTasks', JSON.stringify(tasks.value))
}
</script>