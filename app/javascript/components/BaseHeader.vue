<template>
  <component :is="tag">
    <slot />
  </component>
</template>

<script setup>
defineProps({
  tag: {
    type: String,
    default: 'h1',
    validate: t => ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'].includes(t)
  }
})
</script>