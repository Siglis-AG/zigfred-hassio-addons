# Documentation

## How to use

1. Add the Github repo to your Hass.io: <https://github.com/Siglis-AG/zigfred-hassio-addons>
2. Install the `lovelace-mushroom` addon and start it.
3. Add reference to `mushroom.js` in Dashboard. There's two way to do that:
    - **Using UI:** _Settings_ → _Dashboards_ → _More Options icon_ → _Resources_ → _Add Resource_ → Set _Url_ as `/local/mushroom.js` → Set _Resource type_ as `JavaScript Module`.
      **Note:** If you do not see the Resources menu, you will need to enable _Advanced Mode_ in your _User Profile_
    - **Using YAML:** Add following code to `lovelace` section.
        ```yaml
        resources:
            - url: /local/mushroom.js
              type: module
        ```

Now you should be able to use *lovelace-mushroom* cards in your dashboard.