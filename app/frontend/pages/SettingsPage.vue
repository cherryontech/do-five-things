<template>
  <div>
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.settings') }}</h1>

    <h2 class="mb-16 text-2xl text-center">{{ $t('flavorText.whatFiveThings') }}</h2>

    <ol class="dft-list-layout">
      <li v-for="(num, index) in 5" :key="index">
        <TaskInput :taskNumber="num" v-model="taskInputs[index]" />
      </li>
    </ol>

    <code>
    Inputs: 
    <ol>
      <li v-for="(input, index) in taskInputs" :key="index">
        {{ input }}
      </li>
    </ol>
    </code>
  </div>
</template>

<script setup lang="ts">
import TaskInput from '../components/TaskInput.vue';

import { reactive } from 'vue'

const taskInputs = reactive([])
</script>