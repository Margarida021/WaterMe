import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dividionphoto"
export default class extends Controller {
  static targets = ["form", "list"]

  connect() {
    var photos = ['http://res.cloudinary.com/dtng1edik/image/upload/v1693497849/kbvpguyowi4nn3itrkyp.png', 'http://res.cloudinary.com/dtng1edik/image/upload/v1693497878/xi4tldxzvwv1toxjswtd.png', 'http://res.cloudinary.com/dtng1edik/image/upload/v1693497857/emyd1xdnhkz0yedthvz8.png', 'http://res.cloudinary.com/dtng1edik/image/upload/v1693497819/ggtlaquzlzpoqijj7wfj.png', 'http://res.cloudinary.com/dtng1edik/image/upload/v1693497889/yyzkq4ccq0vxq52rhr4z.png', 'http://res.cloudinary.com/dtng1edik/image/upload/v1693497864/qidbs6seafhcydyobexp.png', 'http://res.cloudinary.com/dtng1edik/image/upload/v1693497901/bil78gqw6mzmloctxklw.png', 'http://res.cloudinary.com/dtng1edik/image/upload/v1693497391/nesryoxojymgi5ahguyl.png', 'http://res.cloudinary.com/dtng1edik/image/upload/v1693497833/iqci6mwndrvf09jxdoeq.png']
    var childNodes = document.querySelectorAll('.lc');
    if (childNodes) {
    for (var i in childNodes) {
      childNodes[i].insertAdjacentHTML("afterbegin", `<img src="${photos[i]}" style="width:80px; height:80px">`)
    }}
}
}
