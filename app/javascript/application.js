// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import './controllers'
import * as bootstrap from 'bootstrap'

import { Application } from '@hotwired/stimulus'
import Clipboard from 'stimulus-clipboard'

const application = Application.start()
application.register('clipboard', Clipboard)
