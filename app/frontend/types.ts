export type Task = {
  id: number
  text: string,
  order: number,
  completed: boolean
}

export type Prog = {
  id: number,
  completed: boolean,
  completed_at: Date,
  date: Date
}

export type Startdate = string