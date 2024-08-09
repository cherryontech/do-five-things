import TaskInput from './TaskInput.vue';

// More on how to set up stories at: https://storybook.js.org/docs/writing-stories
export default {
  title: 'Inputs/TaskInput',
  component: TaskInput,
  tags: ['autodocs'],
};

// More on writing stories with args: https://storybook.js.org/docs/writing-stories/args
export const Base = {
  args: {
    modelValue: 'Hello this is some nice example input',
    taskNumber: 999,
  },
};
