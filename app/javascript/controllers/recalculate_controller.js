import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["total", "price", "tax", "subtotal", "taxtotal", "grandtotal"];

  initialize() {
    // let theids = []
    // this.theidTargets.forEach((element, index) => {
    //   theids[index] = element.id.match(/\d/g).join("")
    // })
    // this.totalTargets.forEach((element, index) => {
    //   element.id = theids[index]
    // })
    // this.priceTargets.forEach((element, index) => {
    //   element.id = theids[index]
    // })
    // this.taxTargets.forEach((element, index) => {
    //   element.id = theids[index]
    // })
  }

  recalculate(event) {
    const formatter = new Intl.NumberFormat(undefined, {
      style: 'currency',
      currency: 'EUR',
    });

    let eventId = event.target.id.match(/\d/g).join("")
    let itemPrice = ""
    let itemTax = ""
    let subTotal = 0
    let itemTotal = 0
    let sum = 0
    let taxesArray = []

    this.taxTargets.forEach((tax, index) => {
      taxesArray[index] = this.convertNum(tax.textContent)
    })

    this.totalTargets.forEach((element, index) => {
      if (element.id.match(/\d/g).join("") == eventId) {
        this.priceTargets.forEach((price, index) => {
          if (price.id.match(/\d/g).join("") == eventId) {
            itemPrice = this.convertNum(price.textContent)
          }
        })
        this.taxTargets.forEach((tax, index) => {
          if (tax.id.match(/\d/g).join("") == eventId) {
            itemTax = this.convertNum(tax.textContent)
          }
        })
        itemTotal = itemPrice * (1 + itemTax/100) * event.target.value
      }
      sum += itemTotal

      subTotal += itemTotal / (1 + taxesArray[index]/100) 
    })

    this.subtotalTarget.textContent = formatter.format(subTotal)
    this.taxtotalTarget.textContent = formatter.format(sum - subTotal)
    this.grandtotalTarget.textContent = formatter.format(sum)
  }

  convertNum(element) {
    return element.replace('€', '').replace('&euro', '').replace(',', '.').trim() * 1
  }

}
