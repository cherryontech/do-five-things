import BaseButton from './BaseButton.vue';

// More on how to set up stories at: https://storybook.js.org/docs/writing-stories
export default {
  title: 'Controls/BaseButton',
  component: BaseButton,
  tags: ['autodocs'],
  render: (args) => ({
    components: { BaseButton },
    setup() {
      return { args };
    },
    template: `
      <BaseButton v-bind="args">
        <template v-slot:default>
          {{ args.slotText }}
        </template>
      </BaseButton>
    `,
  }),
};

// More on writing stories with args: https://storybook.js.org/docs/writing-stories/args
export const Base = {
  args: {
    slotText: 'Click me for the answer',
  }
};
