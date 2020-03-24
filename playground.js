async function loadModule() {
  return fetch('./factorial.wasm')
  .then(response => 
    response.arrayBuffer()
  ).then(bytes => 
    WebAssembly.instantiate(bytes)
  ).then(results => { 
    console.log("Loaded wasm module", results);
    const instance = results.instance;
    console.log("instance", instance);
    return instance
  })
}

document.getElementById('go').addEventListener('click', async () => {
  const M = await loadModule()

  const n = document.getElementById('n').value
  const response = M.exports.main(n)
  document.getElementById('result').textContent = response
})
