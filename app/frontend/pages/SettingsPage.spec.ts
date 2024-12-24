import { shallowMount } from '@vue/test-utils'
import { expect, it, vi, describe } from "vitest"
import { router } from '@inertiajs/vue3'

import SettingsPage from './SettingsPage.vue'
import TaskInput from '../components/TaskInput.vue'

function factory(opts: Record<string, any> = {}) {
  const wrapper = shallowMount(SettingsPage, {
    props: {
      tasks: [],
      ...opts.props
    },
    global: {
      mocks: {
        $t: (msg) => msg,
        route: vi.fn()
      }
    },
    attachTo: opts.attachTo || null
  })

  return wrapper
}

it('shows a list of empty tasks when there are no tasks yet created', () => {
  const wrapper = factory()

  wrapper.findAll('[data-test="taskList"] > li').forEach(task => {
    expect(task.findComponent(TaskInput).props('modelValue')).toBe('')
  })
})

it('shows a list with 5 task list items', () => {
  const wrapper = factory()

  expect(wrapper.findAll('[data-test="taskList"] > li')).toHaveLength(5)
})

it('populates the empty task inputs with available tasks from the server', () => {
  const wrapper = factory({
    props: {
      tasks: [
        { id: 888, text: 'blueberries', order: 1, completed: false },
        { id: 999, text: 'raspberries', order: 3, completed: false }
      ]
    }
  })

  expect(wrapper.findAllComponents(TaskInput)[0].props('modelValue')).toBe('blueberries')
  expect(wrapper.findAllComponents(TaskInput)[1].props('modelValue')).toBe('')
  expect(wrapper.findAllComponents(TaskInput)[2].props('modelValue')).toBe('raspberries')
  expect(wrapper.findAllComponents(TaskInput)[3].props('modelValue')).toBe('')
  expect(wrapper.findAllComponents(TaskInput)[4].props('modelValue')).toBe('')
})



describe('when saving the settings page', () => {
  it('passes an error to the input if there is any error and the input has no text', async () => {
    const wrapper = factory({
      props: {
        tasks: [
          { id: 888, text: 'blueberries', order: 1, completed: false },
          { id: 999, text: 'raspberries', order: 2, completed: false },
          { id: 999, text: 'raspberries', order: 3, completed: false },
          // The server did not return a fourth task
          { id: 999, text: 'raspberries', order: 5, completed: false }
        ]
      }
    })

    wrapper.find('form').trigger('submit')
    await wrapper.vm.$nextTick()

    expect(wrapper.findAllComponents(TaskInput)[0].props('hasError')).toBe(false)
    expect(wrapper.findAllComponents(TaskInput)[1].props('hasError')).toBe(false)
    expect(wrapper.findAllComponents(TaskInput)[2].props('hasError')).toBe(false)
    expect(wrapper.findAllComponents(TaskInput)[3].props('hasError')).toBe(true) // The fourth task was empty when the user tried to save
    expect(wrapper.findAllComponents(TaskInput)[4].props('hasError')).toBe(false)
  })

  it('shows error text if any of the inputs are empty', async () => {
    const wrapper = factory({
      props: {
        tasks: [
          { id: 888, text: 'blueberries', order: 1, completed: false },
          { id: 999, text: 'raspberries', order: 2, completed: false },
          { id: 999, text: 'raspberries', order: 3, completed: false },
          // The server did not return a fourth task
          { id: 999, text: 'raspberries', order: 5, completed: false }
        ]
      }
    })

    wrapper.find('form').trigger('submit')
    await wrapper.vm.$nextTick()

    expect(wrapper.find('[data-test="errorMessage"]').exists()).toBe(true)
  })

  it('focuses the error text if any of the inputs are empty', async () => {
    const wrapper = factory({
      props: {
        tasks: [
          { id: 888, text: 'blueberries', order: 1, completed: false },
          { id: 999, text: 'raspberries', order: 2, completed: false },
          { id: 999, text: 'raspberries', order: 3, completed: false },
          // The server did not return a fourth task
          { id: 999, text: 'raspberries', order: 5, completed: false }
        ]
      },
      attachTo: document.body
    })

    wrapper.find('form').trigger('submit')
    await wrapper.vm.$nextTick()

    expect(wrapper.find('[data-test="errorMessage"]').element).toBe(document.activeElement)

  })

  it('posts tasks to the router', async () => {
    const post = vi.fn()

    router.post = post

    const validTasks = [
      { id: 888, text: 'blueberries', order: 1, completed: false },
      { id: 999, text: 'raspberries', order: 2, completed: false },
      { id: 999, text: 'raspberries', order: 3, completed: false },
      { id: 999, text: 'raspberries', order: 4, completed: false },
      { id: 999, text: 'raspberries', order: 5, completed: false }
    ]

    const wrapper = factory({
      props: {
        tasks: validTasks
      },
      attachTo: document.body
    })

    wrapper.find('form').trigger('submit')
    await wrapper.vm.$nextTick()

    expect(post).toHaveBeenCalledTimes(1)
    expect(post).toHaveBeenCalledWith(expect.anything(), { tasks: validTasks })
  })
})

