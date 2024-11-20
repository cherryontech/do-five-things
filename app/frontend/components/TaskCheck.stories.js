import TaskCheck from './TaskCheck.vue';

// More on how to set up stories at: https://storybook.js.org/docs/writing-stories
export default {
  title: 'Buttons/TaskCheck',
  component: TaskCheck,
  tags: ['autodocs'],
};

// More on writing stories with args: https://storybook.js.org/docs/writing-stories/args
export const Base = {
  args: {
    isChecked: false,
    task: { text: 'Wash face', id: 99},
  },
};
