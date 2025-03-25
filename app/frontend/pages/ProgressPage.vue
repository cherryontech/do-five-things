<template>
  <div>
    <h1>{{ $t('pageTitles.progress') }}</h1>
   <p>This is the progress page</p>
   <p>days checked in: {{ progs.length }}</p>
   <p>completed days: {{ completedProgs.length }}</p>
  </div>
</template>

<script setup lang="ts">
import { Prog } from '../types'
const props = defineProps<{ progs: Prog[] }>()

const progs = props.progs

const completedProgs = progs.filter(prog => prog.completed)
</script>
