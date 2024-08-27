import NavLink from './NavLink.vue';

// More on how to set up stories at: https://storybook.js.org/docs/writing-stories
export default {
  title: 'Controls/NavLink',
  component: NavLink,
  tags: ['autodocs'],
  render: (args) => ({
    components: { NavLink },
    setup() {
      return { args };
    },
    template: `
      <div class="bg-dft-secondary">
        <NavLink v-bind="args">
          <template v-slot:default>
            {{ args.slotText }}
          </template>
        </NavLink>
      </div>
    `,
  }),
};

// More on writing stories with args: https://storybook.js.org/docs/writing-stories/args
export const Base = {
  args: {
    icon: 'cog',
    linkDest: 'https://example.com',
    slotText: 'Settings'
  },
  argTypes: {
    icon: {
      control: 'select',
      options: ['cog', 'sun', 'thermometer']
    }
  }
};
