// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application";

import HelloController from "./hello_controller";
application.register("hello", HelloController);

import FlashController from "./flash_controller";
application.register("flash", FlashController);

import BuildingController from "./building_controller";
application.register("building", BuildingController);

import AutosubmitController from "./autosubmit_controller";
application.register("autosubmit", AutosubmitController);

import RenderNoAccessReasonController from "./render_controller";
application.register("render", RenderNoAccessReasonController);

import ConfirmRedirectController from "./confirm_redirect_controller";
application.register("redirect", ConfirmRedirectController);

import RoomTicketsController from "./room_tickets_controller";
application.register("room-tickets", RoomTicketsController);
