import "bootstrap";
import { trixInit } from "../plugins/trix_init";

trixInit();

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
