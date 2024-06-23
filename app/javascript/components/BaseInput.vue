<template>
  <label :for="inputId">
    <slot name="label">
      Default label
    </slot>
  </label>
  <input :aria-describedby="errorText && hasError ? `${inputId}-error` : undefined"
    :aria-invalid="hasError || undefined" v-model="model" type="text" :id="inputId" />

  <BaseErrorText v-if="hasError && errorText" :id="`${inputId}-error`">
    {{ errorText }}
  </BaseErrorText>
</template>

<script setup lang="ts">
import BaseErrorText from './BaseErrorText.vue';

import SetupUuid from '../composables/SetupUuid';

import { computed } from 'vue';

defineProps({
  hasError: {
    type: Boolean,
    default: false
  },
  errorText: {
    type: String,
    default: ''
  }
})

const model = defineModel()

const { uuid } = SetupUuid()

const inputId = computed(() => {
  return `input-${uuid}`
})

</script>