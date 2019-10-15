/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_compute_address" "address" {
  count  = 2
  name   = "nat-external-address-${count.index}-${random_string.suffix.result}"
  region = var.region
}

module "example" {
  source = "../../../examples/advanced"

  project_id    = var.project_id
  region        = var.region
  router_name   = google_compute_router.router.name
  nat_addresses = google_compute_address.address.*.self_link

  subnetworks = [
    {
      name                     = google_compute_subnetwork.subnetwork-a.self_link
      source_ip_ranges_to_nat  = ["ALL_IP_RANGES"]
      secondary_ip_range_names = []
    }
  ]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
}
