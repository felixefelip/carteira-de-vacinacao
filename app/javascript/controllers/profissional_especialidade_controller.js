import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["profissional", "especialidade"]

  selecionar() {
    const especialidadeId = this.profissionalTarget.selectedOptions[0]?.dataset.especialidadeId

    if (especialidadeId) this.especialidadeTarget.value = especialidadeId
  }
}
