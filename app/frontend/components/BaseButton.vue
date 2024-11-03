<template>
  <button class="py-3 px-12 text-2xl border-2 rounded-full transition ease-in-out focus:text-dft-black active:text-dft-black active:bg-dft-primary hover:text-dft-black hover:bg-dft-primary"
  :class="hasError ? 'text-dft-error border-dft-error' : 'text-dft-primary border-dft-primary'"
  >
    <slot/>
  </button>
</template>

<script setup lang="ts">
defineProps({
  hasError: {
    type: Boolean,
    default: false
  }
})
</script>
