import jwt from "jsonwebtoken";
import {config} from "../../authconfig.js";

const verifyToken = (req, res, next) => {
    let token = req.headers["x-access-token"];
  
    if (!token) {
      return res.status(403).send({
        message: "No se proporciona token!"
      });
    }
  
    jwt.verify(token, config.secret, (err, decoded) => {
      if (err) {
        return res.status(401).send({
          message: "No autorizado!"
        });
      }
      req.userId = decoded.id;
      next();
    });
};
  
const authJwt = {
    verifyToken: verifyToken,
};

export default authJwt;