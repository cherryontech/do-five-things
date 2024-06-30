let uuid = 0

export default function () {
  const id = uuid.toString()
  uuid += 1

  return { 
    uuid: id 
  }
}
