<template>
  <button :aria-pressed="isChecked"
    class="flex items-center w-full gap-4 p-5 border text-start border-dft-primary rounded-dft-input">
    <span class="w-6 h-6 border-2 rounded shrink-0 border-dft-primary" :class="{ 'bg-dft-primary': isChecked }"></span>

    <span class="px-2" :class="{ 'line-through': isChecked }">{{ task.text }}</span>
  </button>
</template>

<script setup lang="ts">
import { PropType } from 'vue'
import { Task } from '../types'

defineProps({
  isChecked: {
    type: Boolean,
    default: false
  },
  task: {
    type: Object as PropType<Task>,
    required: true
  }
})

</script>