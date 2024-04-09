customElements.define('s-k-y',
class extends HTMLElement {
  static get observedAttributes() {
    //
    return ["open"];
  }
  constructor() {
    //
    super();
    this.attachShadow({ mode: 'open' });
    this.shadowRoot.adoptedStyleSheets = [sharedStyles];
    this.shadowRoot.innerHTML = `
      <style>
        :host {
          position: fixed;
          display: flex;
          flex-flow: row nowrap;
          width: 100%;
          height: 100%;
          padding: 4px;
          gap: 4px;
        }
        section {
        }
      </style>
      <nav id="nav" class="fc g2 p1 f2" ondrop="console.log('droppy')">
        <button
          class="p2 bold b2 br2 hover mono wfc"
          onclick="this.getRootNode().host.toggleAttribute('open')"
          >
          ≡
        </button>
        <div id="aside" class="fc g2 hidden wf" style="width: 200px; user-select: none;">
          <button
            class="p2 tc hover br2 b1"
            onclick="this.getRootNode().host.newTab()"
            >
            +
          </button>
          <div id="tabs" class="fc g1 wf">
            <template id="tab-template">
              <div class="mono fr b1 br1" style="cursor: pointer;">
                <button
                  class="action p2 b1 hover br1"
                >+</button>
                <button
                  class="action p2 b1 hover grow tl br1"
                ></button>
                <button
                  class="action p2 hover br1"
                >x</button>
              </div>
            </template>
          </div>
        </div>
      </nav>
      <div id="cs0" class="fr wf hf g2">
        <section
          id="ws0"
          class="fc grow hidden wf hf br1"
          >
          <slot id="s0" name="s0"></slot>
        </section>
        <div id="cs1" class="fc g2">
          <section id="ws1" class="fc grow hidden wf hf br1">
            <slot id="s1" name="s1"></slot>
          </section>
          <div id="cs2" class="fr g2">
            <section id="ws2" class="fc grow hidden wf hf br1">
              <slot id="s2" name="s2"></slot>
            </section>
            <div id="cs3" class="fc g2">
              <section
                id="ws3"
                class="fc grow hidden wf hf br1"
                >
                <slot id="s3" name="s3"></slot>
              </section>
            </div>
          </div>
        </div>
      </div>
      <div class="hidden">
        <slot name="s-"></slot>
        <slot id="default"></slot>
      </div>
    `;
  }
  connectedCallback() {
    //
    this.gid("s0")?.addEventListener("slotchange", () => {this.reactSlot("s0")});
    this.gid("s1")?.addEventListener("slotchange", () => {this.reactSlot("s1")});
    this.gid("s2")?.addEventListener("slotchange", () => {this.reactSlot("s2")});
    this.gid("s3")?.addEventListener("slotchange", () => {this.reactSlot("s3")});
    this.gid("default")?.addEventListener("slotchange", (e) => this.reactDefault(e));
    this.addEventListener("here-change", (e) => {
      this.updateTabs();
    })
  }
  attributeChangedCallback(name, oldValue, newValue) {
    //
    if (name === "open") {
      this.gid("aside").classList.toggle("hidden");
    }
  }
  gid(id) {
    //
    return this.shadowRoot.getElementById(id);
  }
  slotted(id) {
    //
    return (this.gid(id)?.assignedElements() || [null])[0];
  }
  trueSlots() {
    //
    let kids = [...this.childNodes];
    let slotted = kids.filter(k => {
      return k.hasAttribute("slot");
    })
    let sorted = [...slotted];
    sorted.sort((a, b) => {
      let sa = a.getAttribute("slot");
      let sb = b.getAttribute("slot");
      return sa > sb;
    })
    kids.forEach(k => {
      k.removeAttribute("slot");
    })
    sorted.forEach((c, i) => {
      c.setAttribute("slot", `s${i}`);
    })
    this.updateTabs();
  }
  reactSlot(id) {
    //
    const s = this.slotted(id);
    let c = this.gid("c"+id);
    let w = this.gid("w"+id);
    if (s) {
      s.style.flexGrow = '1';
      s.style.display = 'flex';
      s.style.width = '100%';
      s.style.height = '100%';
      s.style.overflowY = 'scroll'
      s.style.borderRadius = '4px';
      s.style.backgroundColor = 'white';
      c.style.flexGrow = '1';
      c.style.width = '100%';
      c.style.height = '100%';
      w.classList.remove('hidden');
      //
    } else if (c) {
      c.style.flexGrow = '0';
      c.style.width = '0';
      c.style.height = '0';
      w.classList.add('hidden');
    }
    this.updateTabs();
  }
  reactDefault(e) {
    //
    this.updateTabs();
  }
  updateTabs() {
    //
    let frames = [...this.childNodes];
    let tabs = this.gid("tabs");
    tabs.querySelectorAll('div').forEach(x => x.remove());
    frames.forEach((f, i) => {
      let here = f.getAttribute('here');
      let label = f.getAttribute('label');
      let open = f.hasAttribute('slot');
      let tab = this.gid('tab-template').content.cloneNode(true);
      tab = tab.querySelector('div');
      if (open) {
        tab.classList.add('active');
      }
      let add = tab?.firstElementChild;
      let sel = add.nextElementSibling;
      let del = sel.nextElementSibling;
      sel.textContent = label || here;
      sel.addEventListener('click', (e) => {
        e.preventDefault();
        frames.forEach(f => {
          f.removeAttribute("slot");
        });
        f.setAttribute("slot", "s-");
        this.trueSlots();
      })
      add.addEventListener('click', (e) => {
        e.preventDefault();
        if (!open) {
          f.setAttribute("slot", "s-");
          this.trueSlots();
          tab.classList.add("active");
        } else {
          f.removeAttribute("slot");
          this.trueSlots();
          tab.classList.remove("active");
        }
      })
      del.addEventListener('click', (e) => {
        e.preventDefault();
        f.remove();
        this.trueSlots();
      });
      tabs.appendChild(tab);
    })
  }
  newTab() {
    //
    let hawk = document.createElement("ha-wk");
    let stub = document.createElement("div");
    stub.setAttribute("hx-get", "/neo/hawk");
    stub.setAttribute("hx-swap", "outerHTML");
    stub.setAttribute("hx-trigger", "load");
    hawk.appendChild(stub);
    hawk.setAttribute("slot", "s-");
    hawk.setAttribute("here", "/");
    hawk.setAttribute("label", "Home");
    this.insertAdjacentElement("afterbegin", hawk);
    this.trueSlots();
    htmx.process(document.body);
  }
});
