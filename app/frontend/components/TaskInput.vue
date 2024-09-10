<template>
  <div class="flex items-baseline gap-4 py-5 border-2 border-dft-primary rounded-dft-input">
    <label :for="taskId" class="flex items-center text-xl ml-9">
      <span class="sr-only">{{ $t('labels.task') }}</span>
      <span>{{ taskNumber }}.</span>
    </label>
    <input class="p-0 leading-none bg-transparent border-0 border-b border-dft-white" :id="taskId" type="text"
      :value="modelValue" @input="$emit('update:modelValue', $event.target.value)" />
  </div>
</template>

<script setup lang="ts">
import SetupUid from '../composables/SetupUid'

import { ref } from 'vue'

defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  taskNumber: {
    type: Number,
    default: 1
  }
})

defineEmits<{
  'update:modelValue': [value: string]
}>()

const { uid } = SetupUid()

const taskId = `task-${uid}`

</script>