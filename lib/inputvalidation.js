const validator = require('node-validator');
const sanitizeHtml = require('sanitize-html');

const checkRegistration = validator.isObject()
  .withRequired('email', validator.isString({
    regex: /^(?=.{1,50}$)\S+@\S+$/,
    message: 'invalid email, must be shorter than 50 characters.'
  }))
  .withRequired('newsletter', validator.isBoolean());

const sanitizeUserInput = function(data) {
  Object.keys(data).forEach((key) => {
    const val = data[key];
    data[key] = sanitizeHtml(val);
  });
  return data;
}

module.exports = {
  escapeHtml: sanitizeUserInput,
  registration: validator.express(checkRegistration),
};
