<template>
  <div>
    <h1>{{ $t('pageTitles.today') }}</h1>
    <h2 class="mb-16 text-2xl text-center">
      {{ $t('emptyStates.todayPage.text1') }}
      <Link class="dft-prose-link" href="/settings">{{ $t('emptyStates.todayPage.link1') }}</Link>
      {{ $t('emptyStates.todayPage.text2') }}
    </h2>

    <ol class="dft-list-layout">
      <li v-for="task in sortedTasks" :key="task.id">
        <TaskCheck :task="task" :isChecked="task.completed" @click="updateIsChecked(task.id)" />
      </li>
    </ol>
  </div>
</template>

<script setup lang="ts">
import { Link } from '@inertiajs/vue3'

import TaskCheck from '../components/TaskCheck.vue';

import { computed, reactive } from 'vue'
import { Task } from '../types'

const tasks: Task[] = reactive([
  { id: 939, order: 3, completed: true, text: "Wash my face" },
  { id: 297, order: 4, completed: false, text: "Make my bed and do another thing but this other thing might grab my attention so I will try to do it too" },
  { id: 584, order: 2, completed: false, text: "Shower!" },
  { id: 837, order: 5, completed: true, text: "Empty litter" },
  { id: 102, order: 1, completed: false, text: "Brush teeth" }
])

const sortedTasks = computed(() => {
  return tasks.sort((a,b) => { return a.order - b.order })
})


const updateIsChecked = (taskId: Task['id']) => {
  const currentTask = tasks.find(el => el.id === taskId)

  if(currentTask) {
    currentTask.completed = !currentTask.completed
  }
}
</script>