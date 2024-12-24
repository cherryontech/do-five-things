<template>
  <form @submit.prevent="validateAndSave" class="mx-auto max-w-sm flex flex-col">
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.settings') }}</h1>

    <h2 class="mb-16 text-2xl text-center">{{ $t('flavorText.whatFiveThings') }}</h2>

    <div aria-live="assertive" class="text-dft-error" :class="{ 'my-5': anyError }">
      <p data-test="errorMessage" tabindex="-1" v-if="anyError" id="errorText" ref="errorTextRef">{{ $t('settingsPage.errorText') }}</p>
    </div>

    <p class="max-w-xs mx-auto p-6 pt-0 mt-5 order-last text-dft-error" id="legend">{{ $t('settingsPage.legend') }}</p>

    <ol class="dft-list-layout mb-7" data-test="taskList" id="wtf">
      <li v-for="task in tasksToManipulate" :key="task.order">
        <TaskInput :data-test="`task-${task.order}`" :aria-describedby="`${anyError && !task.text ? 'errorText' : ''} legend`" :taskNumber="task.order"
          v-model="task.text" :hasError="anyError && !task.text" />
      </li>
    </ol>

    <BaseButton data-test="saveButton" class="order-last my-5 mx-auto block" :hasError="anyError">
      {{ $t('labels.save') }}
    </BaseButton>
  </form>
</template>

<script setup lang="ts">
import { router } from '@inertiajs/vue3'
import BaseButton from '../components/BaseButton.vue'
import TaskInput from '../components/TaskInput.vue';

import { Ref, computed, reactive, ref } from 'vue'

interface Task {
  id: number | null,
  text: string
  order: number
  completed: boolean
}

const props = defineProps<{ tasks: Task[] }>()

const orderedTasks = computed(() => {
  const tasks = [
    { id: null, order: 1, text: '', completed: false },
    { id: null, order: 2, text: '', completed: false },
    { id: null, order: 3, text: '', completed: false },
    { id: null, order: 4, text: '', completed: false },
    { id: null, order: 5, text: '', completed: false },
  ]

  return tasks.map(task => {
    const serverTask = props.tasks?.find((t: Task) => t.order === task.order)
    if (serverTask) {
      return { ...task, ...serverTask }
    }
    return task
  })
})

const tasksToManipulate = reactive(orderedTasks.value)


const isDirty = ref(false)

const anyError = computed(() => {
  // If we don't have any inputs, the app isn't usable
  if (!tasksToManipulate || tasksToManipulate.length === 0) return true

  // If the user hasn't tried saving the form yet, we don't need to validate
  if (!isDirty.value) return false

  return tasksToManipulate.some(task => {
    return !Boolean(task.text)
  })
})

const errorTextRef: Ref<HTMLElement | null> = ref(null)

const validateAndSave = async () => {
  // User has interacted with the form
  isDirty.value = true

  if (anyError.value && errorTextRef.value) {
    errorTextRef.value?.focus()
    return
  }

  router.post('/settings', { tasks: tasksToManipulate })
  // TODO: Save confirmation toast
}
</script>
