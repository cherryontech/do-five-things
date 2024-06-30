<template>
  <input v-model="model" type="checkbox" :id="checkboxId" />
  <label :for="checkboxId">
    <slot name="label">
      Default Checkbox label
    </slot>
  </label>

  <BaseErrorText v-if="hasError && errorText" :id="`${checkboxId}-error`">
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

const checkboxId = computed(() => {
  return `input-${uuid}`
})

</script>