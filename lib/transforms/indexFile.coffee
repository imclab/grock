###
# # Rename Index File
###

path = require 'path'
map = require('event-stream').map

module.exports = (indexFile) ->
  # Process only one index file
  found = false

  modifyFile = (file, cb) ->
    filePath = file.originalRelative or file.relative
    if not found and (filePath is indexFile)
      file.path = path.join(path.dirname(file.path), 'index.html')
      found = true
    
    cb(null, file)

  # Skip checks where there is nothing to be checked
  if (not indexFile) or (indexFile is '')
    modifyFile = (file, cb) -> cb(null, file)

  return map(modifyFile)
