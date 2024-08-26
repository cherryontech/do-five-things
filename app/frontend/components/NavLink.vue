<template>
  <Link :href="linkDest" class="flex flex-col items-center justify-end h-full rounded-t-xl text-dft-black hover:bg-dft-secondary-dimmed">
    <BaseIcon :icon="icon" />
    <slot />
  </Link>
</template>

<script setup lang="ts">
import { Link } from '@inertiajs/vue3'
import BaseIcon from './BaseIcon.vue'

import { defineProps } from 'vue'

defineProps({
  icon: {
    type: String,
    default: ''
  },
  linkDest: {
    type: String,
    required: true
  }
})
</script>