<template>
  <div :class="hasError ? 'border-dft-error ring-dft-error' : 'border-dft-primary ring-dft-primary'"
    class="transition ease-in-out focus-within:ring-4 ring-inset flex items-baseline gap-4 py-5 px-9 border-2 rounded-dft-input">

    <label :for="taskId" class="flex items-center text-xl" :class="{ 'text-dft-error': hasError }">
      <span class="sr-only">{{ $t('labels.task') }}</span>
      <span>{{ taskNumber }}.</span>
      <span v-if="hasError">*</span>
    </label>

    <input :aria-describedby="$attrs['aria-describedby'] as string || undefined" :aria-invalid="hasError || undefined"
      class="w-full p-0 leading-none bg-transparent border-0 border-b" :id="taskId" type="text"
      :class="hasError ? 'border-dft-error' : 'border-dft-white'"
      :value="modelValue" @change="$emit('update:modelValue', ($event.target as HTMLInputElement).value)" />
  </div>
</template>

<script setup lang="ts">
import SetupUid from '../composables/SetupUid'

defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  taskNumber: {
    type: Number,
    default: 1
  },
  hasError: {
    type: Boolean,
    default: false
  }
})

defineEmits<{
  'update:modelValue': [value: string]
}>()

const { uid } = SetupUid()

const taskId = `task-${uid}`

</script>