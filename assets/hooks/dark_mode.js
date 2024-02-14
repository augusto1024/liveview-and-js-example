const DARK_MODE_FLAG = 'dark-mode-enabled'

export default {
  mounted() {
    const inputId = this.el.dataset.darkModeInput
    const input = document.getElementById(inputId)
    toggleDarkMode(input)

    input.addEventListener('change', (e) => {
      localStorage.setItem(DARK_MODE_FLAG, e.target.checked)
      toggleDarkMode(input)
    })
  }
}

function toggleDarkMode(input) {
  const isDarkMode = localStorage.getItem(DARK_MODE_FLAG) === 'true'
  document.querySelector('html').classList.toggle('dark', isDarkMode)
  input.checked = isDarkMode
}
