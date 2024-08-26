import BaseIcon from './BaseIcon.vue';

// More on how to set up stories at: https://storybook.js.org/docs/writing-stories
export default {
  title: 'Graphics/BaseIcon',
  component: BaseIcon,
  tags: ['autodocs'],
};

// More on writing stories with args: https://storybook.js.org/docs/writing-stories/args
export const Base = {
  args: {
    icon: 'cog',
    iconAlt: 'Nice alt for icon',
  },
  argTypes: {
    icon: {
      control: 'select',
      options: ['cog', 'sun', 'thermometer']
    }
  }
};
