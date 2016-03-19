mongoose = require '../datasources/mongoose'
{Schema} = mongoose

PostSchema = new Schema
  title: String
  content: String

module.exports = mongoose.model 'Post', PostSchema
