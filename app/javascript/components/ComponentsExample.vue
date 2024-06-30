<template>
    <h1 class="text-3xl font-bold">
      Example app (FE only, no saving)
    </h1>

    <details>
      <summary>Component examples</summary>

      <div class="flex flex-col gap-10">
        <div class="border">
          <h2>Basic text inputs</h2>
          <BaseInput v-model="input1">
            <template #label>
              Cool label one
            </template>
          </BaseInput>

          input1: {{ input1 }}
          <BaseInput v-model="input2" hasError errorText="Doh it is an error">
            <template #label>
              Cool label two
            </template>
          </BaseInput>

          input2: {{ input2 }}
        </div>

        <div class="flex flex-col gap-4 border">
          <h2>Task Input</h2>
          <TaskInput :id="999" placeholder="E.g. blueberries" v-model="oneTaskInputExample">
            <template #label>Snack choice</template>
            <template #errorText>Please fill in your snack choice, so you can have snacks!</template>
          </TaskInput>
          <code>Output: {{ oneTaskInputExample }}</code>
        </div>

        <div class="border">
          <h2>Buttons</h2>
          <BaseButton @click="buttonCount += 1">Click the button to increment!</BaseButton>
          <p>{{ buttonCount }}</p>
        </div>

        <div class="border">
          <h2>Headings</h2>

          <BaseHeader tag="h1">I'm an h1</BaseHeader>
          <BaseHeader tag="h2">I'm an h2</BaseHeader>
          <BaseHeader tag="h3">I'm an h3</BaseHeader>
          <BaseHeader tag="h4">I'm an h4</BaseHeader>
          <BaseHeader tag="h5">I'm an h5</BaseHeader>
          <BaseHeader tag="h6">I'm an h6</BaseHeader>
        </div>

        <div class="border">
          <h2>Checkboxes</h2>

          <BaseCheckbox v-model="checkbox1">
            <template #label>
              Is this checkbox ticked? {{ checkbox1 === false ? 'no' : 'yes' }}
            </template>
          </BaseCheckbox>
        </div>

        <div class="border">
          <h2>Nav bar</h2>
          <NavBar>
            <a href="https://example.com/one">link one</a>
            <a href="https://example.com/two">link two</a>
            <a href="https://example.com/three">link three</a>
          </NavBar>
        </div>

        <div class="border">
          <h2>Task lists</h2>

        </div>

      </div>
    </details>

    <div class="flex flex-gap-10">
      <article class="p-8 border-2 border-black basis-1/3">
        <h1 class="mb-24">Settings</h1>
        <fieldset>
          <legend class="text-2xl mb-14">What 5 things do you want to get done?</legend>
          <TaskInput v-for="inputId in [1, 2, 3, 4, 5]" :key="inputId" :id="inputId" placeholder="Add task"
            @update:modelValue="addOrEditTask(inputId, $event)" class="mt-8">
            <template #label>{{ inputId }}.</template>
            <template #errorText>Please fill in task {{ inputId }}</template>
          </TaskInput>
        </fieldset>
        <p class="m-4 text-sm leading-none">*When you’re done editing your tasks, click save and view your tasks in the
          Today
          page!</p>
        <BaseButton type="submit" @click="saveInitialTasks" class="block w-48 ml-auto">Save</BaseButton>
      </article>

      <article class="p-8 border-2 border-black basis-1/3">
        <h1 class="mb-24">Today</h1>

        <template v-if="!tasksWithStatus.length">
          <h2 class="my-auto text-2xl text-center border">Nothing here yet! Go to settings to add your 5 things.</h2>
        </template>

        <template v-if="tasksWithStatus.length">
          <p class="text-2xl mb-14">You got this!</p>
          <section class="mb-14">
            <h3 class="mb-6">To do {{ remainingTasks.length }}/{{ tasksWithStatus.length }}</h3>
            <ul class="flex flex-col gap-6">
              <li v-for="task in remainingTasks" :key="task.id">
                <DailyTask class="w-full" @click="toggleTaskStatus(task)" :is-complete="task.isComplete">
                  {{ task.name }}
                </DailyTask>
              </li>
            </ul>
          </section>

          <section>
            <h3 class="mb-6">Completed {{ completedTasks.length }}/{{ tasksWithStatus.length }}</h3>
            <ul class="flex flex-col gap-6">
              <li v-for="task in completedTasks" :key="task.id">
                <DailyTask class="w-full" @click="toggleTaskStatus(task)" :is-complete="task.isComplete">
                  {{ task.name }}
                </DailyTask>
              </li>
            </ul>
          </section>
        </template>
      </article>

      <article class="p-8 border-2 border-black basis-1/3">
        <h1 class="mb-24">Progress</h1>
        <p class="text-2xl mb-14">You did x of y days oh wow</p>
      </article>
    </div>
</template>

<script setup>
import BaseButton from './BaseButton.vue';
import BaseCheckbox from './BaseCheckbox.vue';
import BaseHeader from './BaseHeader.vue';
import BaseInput from './BaseInput.vue'
import DailyTask from './DailyTask.vue';
import NavBar from './NavBar.vue';
import TaskInput from './TaskInput.vue';

import { computed, reactive, ref } from 'vue'

const input1 = ref('initial')
const input2 = ref('initial')
const oneTaskInputExample = ref('example choice type over me')

const buttonCount = ref(0)

const checkbox1 = ref(false)

const initialTasks = reactive([])

const tasksWithStatus = ref([])

const addOrEditTask = (id, updatedText) => {
  const currentTask = initialTasks.find(task => task.id === id)

  if (currentTask) {
    currentTask.name = updatedText
  } else {
    initialTasks.push({ id: id, name: updatedText, isComplete: false })
  }
}

const saveInitialTasks = () => {

  if (initialTasks.length !== 5) {
    // TODO: Show errors beneath each input that is not filled in
    // TODO: Figure out what else needs to be done to set the form to has errors - aria has error?
    return
  }

  if (!initialTasks.every(task => task.name)) {
    // TODO: Show errors beneath each input that is not filled in
    // TODO: Figure out what else needs to be done to set the form to has errors - aria has error?
    return
  }

  tasksWithStatus.value = initialTasks
}



const completedTasks = computed(() => {
  return tasksWithStatus.value.filter(t => t.isComplete)
})

const remainingTasks = computed(() => {
  return tasksWithStatus.value.filter(t => !t.isComplete)
})

const toggleTaskStatus = (task) => {
  tasksWithStatus.value.find(t => t.id === task.id).isComplete = !tasksWithStatus.value.find(t => t.id === task.id).isComplete
  // TODO: Update database with new isCompleted status
}
</script>
