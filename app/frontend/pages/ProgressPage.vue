<template>
  <div>
    <h1>{{ $t('pageTitles.progress') }}</h1>
   <p>This is the progress page</p>
   {{ progs.length }}
   {{ completedProgs.length }}
  </div>
</template>

<script setup lang="ts">
import { Prog } from '../types'
const props = defineProps<{ progs: Prog[] }>()

const progs = props.progs

const completedProgs = progs.filter(prog => prog.completed)
</script>
