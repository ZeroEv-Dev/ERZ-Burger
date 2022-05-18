ERZ_COORDINATE = {
    [1] = {
      type = "prodotti", -- FRIGO
      coords = vector3(-1203.07, -895.467, 13.995),
      Items = {
        [1] = {
          name = "carnecongelata",
          count = 1
        },
        [2] = {
          name = "panecongelato",
          count = 1
        },
        [3] = {
            name = "lattugasporca",
            count = 1
        },
      }
    },
    [2] = {
      type = "trasfcarne", -- TRASFORMAZIONE CARNE CONGELATA
      coords = vector3(-1202.06, -897.328, 13.995),
      Items = {
        [1] = {
          name = "carne",   -- ITEM CHE VIENE DATO
          count = 1
        }
      },
      ReqItems = {      -- ITEM RICHIESTO
        [1] = {
          name = "carnecongelata",
          count = 1
        }
      }
    },
    [3] = {
        type = "trasfpane", -- TRASFORMAZIONE PANE
        coords = vector3(-1197.42, -897.531, 13.995),
        Items = {
          [1] = {
            name = "panehamb",
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "panecongelato",
            count = 1
        }
      }
    },
    [4] = {
        type = "trasflattu", -- TRASFORMAZIONE LATTUGA
        coords = vector3(-1197.20, -901.609, 13.995),
        Items = {
          [1] = {
            name = "lattuga",
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "lattugasporca",
            count = 1
        }
      }
    },
    [5] = {
        type = "cucinare", -- CUCINARE
        coords = vector3(-1199.85, -900.669, 13.995),
        Items = {
          [1] = {
            name = "hamburger",   --ITEM FINALE
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "carne",
            count = 1
          },
          [2] = {
            name = "panehamb",
            count = 1
          },
          [3] = {
            name = "lattuga",
            count = 1
          }
        }
      },
  }


Config = {}

Config.NPCAttivo = true -- FALSE SE NON VUOI NPC
Config.NPCModello = 0xF9FD068C -- MODELLO NPC
Config.NPCVendere = { x = -1175.7104492188, y = -892.80584716797, z = 12.802887916565, h = 28.34646 }
Config.NPCTesto = { x = -1175.7104492188, y = -892.80584716797, z = 14.802887916565 }
Config.Vendere = { x = -1175.7104492188, y = -892.80584716797, z = 13.802887916565 }

Config.Prezzo = 320
Config.Item = 'hamburger'