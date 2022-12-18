import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["qty", "price", "tax", "total", "subtotal", "taxtotal", "grandtotal"];

  recalculate(event) {
    const formatter = new Intl.NumberFormat(undefined, {
      style: 'currency',
      currency: 'EUR',
    });

    let itemTotal = 0
    let subTotal = 0
    let grandTotal = 0
    let taxesArray = []
    let qtysArray = []
    let pricesArray = []

    this.taxTargets.forEach((tax, index) => {
      taxesArray[index] = tax.textContent.trim() * 1
    })

    this.qtyTargets.forEach((qty, index) => {
      qtysArray[index] = qty.value
    })
  
    this.priceTargets.forEach((price, index) => {
      pricesArray[index] = this.convertNum(price.textContent)
    })

    this.totalTargets.forEach((element, index) => {

      itemTotal = pricesArray[index] * (1 + taxesArray[index]/100) * qtysArray[index]
      
      element.textContent = formatter.format(itemTotal)

      grandTotal += itemTotal
 
      subTotal += itemTotal / (1 + taxesArray[index]/100) 
    })

    this.subtotalTarget.value = formatter.format(subTotal)
    this.taxtotalTarget.value = formatter.format(grandTotal - subTotal)
    this.grandtotalTarget.value = formatter.format(grandTotal)
  }

  convertNum(element) {
    return element.replace('€', '').replace('&euro', '').replace('.', '').replace(',', '.').trim() * 1
  }

}
