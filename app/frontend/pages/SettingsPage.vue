<template>
  <form @submit.prevent="validateAndSave" class="mx-auto max-w-sm flex flex-col">
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.settings') }}</h1>

    <h2 class="mb-16 text-2xl text-center">{{ $t('flavorText.whatFiveThings') }}</h2>

    <p class="max-w-xs mx-auto p-6 pt-0 mt-5 order-last text-dft-error" id="legend">{{ $t('settingsPage.legend') }}</p>

    <ol class="dft-list-layout">
      <li v-for="(task, index) in templateTasks" :key="task.order">
        <TaskInput :aria-describedby="`${anyError && !task.text ? 'errorText' : ''} legend`" :taskNumber="index + 1"
          v-model="task.text" :hasError="anyError && !task.text" />
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
import { router } from '@inertiajs/vue3'
import BaseButton from '../components/BaseButton.vue'
import TaskInput from '../components/TaskInput.vue';

import { Ref, computed, nextTick, ref } from 'vue'

interface Task {
  id: number,
  text: string
  order: number
  completed: boolean
}

const props = defineProps<{ tasks: Task[] }>()

const tasks = [
  { id: null, order: 1, text: '', completed: false },
  { id: null, order: 2, text: '', completed: false },
  { id: null, order: 3, text: '', completed: false },
  { id: null, order: 4, text: '', completed: false },
  { id: null, order: 5, text: '', completed: false },
]

console.log({p: props.tasks})

const filteredTasks = tasks.map(task => {
  const serverTask = props.tasks?.find((t: Task) => t.order == task.order)
  console.log({serverTask})
  if (serverTask) {
    return {...task, ...serverTask}
  }
  return task
})
const templateTasks: Ref<Task[]> = ref(filteredTasks);

const anyEmpty = computed(() => {
  if (!templateTasks.value || templateTasks.value.length === 0) return true

  return templateTasks.value.some(task => {
    return !Boolean(task.text)
  })
})

const anyError = ref(false)
const errorTextRef: Ref<HTMLElement | null> = ref(null)

const validateAndSave = async () => {
  anyEmpty.value ? anyError.value = true : anyError.value = false

  await nextTick()
  if (anyError.value && errorTextRef.value) errorTextRef.value?.focus()

  router.post('/settings', { tasks: templateTasks.value })
}
</script>
