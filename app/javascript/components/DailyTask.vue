<template>
  <button type="button" class="task-wrapper" :aria-pressed="isComplete">
    <span class="inline-block w-6 h-6 border border-black shrink-0" :class="{ 'bg-slate-600': isComplete }"></span>
    <span :class="{ 'line-through': isComplete }" class="text-left">
      <slot />
    </span>
  </button>
</template>

<script setup>
defineProps({
  isComplete: {
    type: Boolean,
    default: false
  }
})
</script>