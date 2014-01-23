nodecr = require 'nodecr'
util = require 'util'
tmp = require 'tmp'
exec = require('child_process').exec
fs = require 'fs'

nodecr.process "#{__dirname}/test.jpg", (err, text) ->
  console.log util.inspect err
  console.log util.inspect text
, null, null, null,
  ConvertPreprocessor = (inputFile, next) ->
    console.log "node-tesseract: preprocessor: convert: Processing '#{inputFile}'"
    tmp.tmpName postfix: '.tif', (err, outputFile) ->
      if err
        # Something went wrong when generating the temporary filename
        next err, null
        return

      command = [
        'convert'
        '-colorspace'
        'gray'
        '-sharpen'
        '10'
        '-threshold'
        '50%'
        '-colors'
        '32'
        '-normalize'
        inputFile
        outputFile
      ].join ' '
      console.log "node-tesseract: preprocessor: convert: Running '#{command}'"
      exec command, (err, stdout, stderr) ->
        if err
          # Something went wrong executing the convert command
          next err, null
        else
          cleanup = ->
            console.log "node-tesseract: preprocessor: convert: Deleting '#{outputFile}'"
            fs.unlink outputFile, (err) ->
              # ignore any errors here as it just means we have a temporary file left somewehere
              return
            return

          next null, outputFile, cleanup
        return
      return
    return