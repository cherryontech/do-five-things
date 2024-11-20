<template>
  <div class="mx-auto max-w-sm">
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.today') }}</h1>

    <h2 class="mb-16 text-2xl text-center">
      <template v-if="!tasks">
      {{ $t('emptyStates.todayPage.text1') }}
      <Link class="dft-prose-link" href="/settings">{{ $t('emptyStates.todayPage.link1') }}</Link>
      {{ $t('emptyStates.todayPage.text2') }}
      </template>

      <template v-else>
        {{ $t('flavorText.youGotThis') }}
      </template>
    </h2>

    <h3><span class="text-2xl">{{ $t('labels.toDo') }}</span> {{ incompleteTasks.length }}/{{ sortedTasks.length }}</h3>
    <ol v-if="incompleteTasks.length" class="my-6 dft-list-layout">
      <li v-for="task in incompleteTasks" :key="task.id">
        <TaskCheck :task="task" :isChecked="task.completed" @click="updateIsChecked(task.id)" />
      </li>
    </ol>
    <p class="ml-4 my-6" v-else>{{ $t('emptyStates.nothingToSee') }}</p>

    <h3><span class="text-2xl">{{ $t('labels.completed') }}</span> {{ completeTasks.length }}/{{ sortedTasks.length }}</h3>
    <ol class="my-6 dft-list-layout">
      <li v-for="task in completeTasks" :key="task.id">
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

const tasks: Task[] = reactive(localStorage.getItem('dftTasks') ? JSON.parse(localStorage.getItem('dftTasks')!) : [])

const sortedTasks = computed(() => {
  return tasks.sort((a,b) => { return a.order - b.order })
})

const incompleteTasks = computed(() => {
  return sortedTasks.value.filter(task => !task.completed)
})

const completeTasks = computed(() => {
  return sortedTasks.value.filter(task => task.completed)
})

const updateIsChecked = (taskId: Task['id']) => {
  const currentTask = tasks.find(el => el.id === taskId)

  if(currentTask) {
    currentTask.completed = !currentTask.completed
  }

  localStorage.setItem('dftTasks', JSON.stringify(sortedTasks.value))
}
</script>