HID = require("node-hid")
Pusher = require("pusher")
env = require "node-env-file"

env "#{__dirname}/.env"

console.log """
appId: #{process.env.PUSHER_APP}
key: #{process.env.PUSHER_KEY}
secret: #{process.env.PUSHER_SECRET}
"""

pusher = new Pusher(
  appId: process.env.PUSHER_APP
  key: process.env.PUSHER_KEY
  secret: process.env.PUSHER_SECRET
)

device = new HID.HID("USB_1b4f_2b75_14200000")

device.on "data", (data) ->
  console.log data
  pusher.trigger "teapot", "tea_on",
    message: "Tea is on yo!"

device.on "error", (error) ->
  console.log error
