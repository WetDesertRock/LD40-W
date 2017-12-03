return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 100,
  height = 100,
  tilewidth = 100,
  tileheight = 100,
  nextobjectid = 11,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "MapObjects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "Player",
          type = "player",
          shape = "ellipse",
          x = 5000,
          y = 8613,
          width = 100,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "graphicsSwitch",
          type = "switch",
          shape = "rectangle",
          x = 5000,
          y = 8611,
          width = 100,
          height = 89,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "Wall",
          type = "wall",
          shape = "rectangle",
          x = 4400,
          y = 8200,
          width = 100,
          height = 1600,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "Wall",
          type = "wall",
          shape = "rectangle",
          x = 3700,
          y = 9200,
          width = 2000,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "Snatcher",
          type = "snatcher",
          shape = "ellipse",
          x = 5000,
          y = 8300,
          width = 100,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "Follower",
          type = "follower",
          shape = "ellipse",
          x = 5000,
          y = 7800,
          width = 100,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
