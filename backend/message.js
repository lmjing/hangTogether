exports.json = function (res, num, message, err) {
  const json = { code: num, message: message };
  if (num == 1)
    json.err = err;
  // return json;
  return res.status(num).json(json);
};
