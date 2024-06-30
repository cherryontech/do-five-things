<template>
  <div class="task-wrapper">
    <label :for="inputId">
      <slot name="label">
        Default label
      </slot>
    </label>
    <input :aria-describedby="errorText && hasError ? `${inputId}-error` : undefined" :placeholder="placeholder"
      :aria-invalid="hasError || undefined" v-model="model" type="text" :id="inputId"
      class="w-full border-b border-black" />

    <BaseErrorText v-if="hasError && errorText" :id="`${inputId}-error`">
      {{ errorText }}
    </BaseErrorText>
  </div>
</template>

<script setup lang="ts">
import BaseErrorText from './BaseErrorText.vue';

import { computed } from 'vue';

const props = defineProps({
  id: {
    type: Number,
    required: true
  },
  hasError: {
    type: Boolean,
    default: false
  },
  placeholder: {
    type: String,
    default: ''
  },
  errorText: {
    type: String,
    default: ''
  }
})

const model = defineModel()

const inputId = computed(() => {
  return `input-${props.id}`
})

</script>