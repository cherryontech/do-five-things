<template>
  <div>
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.settings') }}</h1>

    <h2 class="mb-16 text-2xl text-center">{{ $t('flavorText.whatFiveThings') }}</h2>

    <form @submit.prevent="submit">
      <ol class="flex flex-col max-w-sm gap-6 mx-auto">
        <li v-for="(num, index) in 5" :key="index">
          <TaskInput :taskNumber="num" :modelValue="form['tasks'][index].name" v-model="form['tasks'][index].name" />
        </li>
      </ol>
      <button type="submit">Submit</button>
    </form>

    <code>
    Inputs:
    <ol>
      <li v-for="(input, index) in tasks" :key="index">
        {{ input }}
      </li>
    </ol>
    Errors:
    <ol>
      <li v-for="(error, index) in errors" :key="index">
        {{ error }}
      </li>
    </ol>
    </code>
  </div>
</template>

<script setup>
import TaskInput from '../components/TaskInput.vue';
import { reactive } from 'vue'
import { router } from '@inertiajs/vue3'

const props = defineProps({
  tasks: {
    type: Array,
    default: [{
      id: Number
    }],
  },
  'task.name': String,
  'task.order': Number,
  errors: Object
})

const form = reactive({
  tasks: props.tasks.map(({ id, name }) => ({ id, name }))
})

console.log(props.tasks)

function submit() {
  router.post('/settings', form)
}

// const taskInputs = reactive([])
</script>
