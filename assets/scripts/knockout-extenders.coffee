ko.extenders.subscribe = (target, fn) ->
  target.subscribe fn
  target

#######################
############ Validation
ko.extenders.required = (target, message) ->
  #add some sub-observables to our observable
  target.hasError = ko.observable()
  target.validationMessage = ko.observable()

  #define a function to do validation
  validate = (newVal) ->
    if newVal? and newVal isnt ''
      target.hasError false
      target.validationMessage ""
    else
      target.hasError true
      target.validationMessage message or "This field is required"
    return

  #initial validation
  validate target()

  #validate whenever the value changes
  target.subscribe validate

  #return the original observable
  target

ko.extenders.email = (target, message) ->
  target.hasError = ko.observable()
  target.validationMessage = ko.observable()
  re = new RegExp(/^\S+@\S+\.\S+$/)

  validate = (newVal) ->
    if newVal? and newVal isnt ''
      if re.test(newVal)
        target.hasError false
        target.validationMessage ""
      else
        target.hasError true
        target.validationMessage message or "Invalid email address. Must be of the form 'john@website.com'"
    else
      target.hasError false
      target.validationMessage ""
    return

  validate target()

  target.subscribe validate

  target

ko.extenders.phone = (target, message) ->
  target.hasError = ko.observable()
  target.validationMessage = ko.observable()
  re = new RegExp(/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/)

  validate = (newVal) ->
    if newVal? and newVal isnt ''
      if re.test(newVal)
        target.hasError false
        target.validationMessage ""
      else
        target.hasError true
        target.validationMessage message or "Invalid phone number. Must be of the form '555-555-5555'"
    else
      target.hasError false
      target.validationMessage ""
    return

  validate target()

  target.subscribe validate

  target

ko.extenders.unique = (target, [unique_in_ko_array, ko_attribute_name, message]) ->
  target.hasError = ko.observable()
  target.validationMessage = ko.observable()

  validate = (newVal) ->
    if newVal? and newVal isnt ''
      attrs = unique_in_ko_array().map((obj) -> obj[ko_attribute_name]())
      if attrs.filter((attr) -> attr is newVal).length > 1
        target.hasError true
        target.validationMessage message or "Must be unique."
      else
        target.hasError false
        target.validationMessage ""
    else
      target.hasError false
      target.validationMessage ""
    return

  validate target()

  target.subscribe validate

  target

#######################
#######################

#######################
################## Misc
ko.extenders.numeric = (target, qualifier) ->
  if 'number' is typeof qualifier
    precision = qualifier
  if 'string' is typeof qualifier
    sign = qualifier
  # create a writable computed observable to intercept writes to our observable
  result = ko.pureComputed(
    read: target # always return the original observables value
    write: (newValue) ->
      current = target()
      if precision
        roundingMultiplier = Math.pow(10, precision)
        newValueAsNum = if isNaN(newValue) then 0 else parseFloat(+newValue)
        valueToWrite = Math.round(newValueAsNum * roundingMultiplier) / roundingMultiplier
      else
        valueToWrite = if isNaN(newValue) then 0 else parseFloat(+newValue)

      if sign and ((sign is 'positive' and valueToWrite < 0) or (sign is 'negative' and valueToWrite > 0))
        valueToWrite *= -1
      # only write if it changed
      if valueToWrite isnt current
        target valueToWrite
      else
        # if the rounded value is the same, but a different value was written, force a notification for the current field
        target.notifySubscribers valueToWrite if newValue isnt current
      return
  ).extend(notify: "always")

  #initialize with current value to make sure it is rounded appropriately
  result target()

  #return the new computed observable
  result

#######################
#######################
