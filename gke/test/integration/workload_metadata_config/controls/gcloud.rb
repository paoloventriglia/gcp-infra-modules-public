# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id = attribute('project_id')
location = attribute('location')
cluster_name = attribute('cluster_name')

control "gcloud" do
  title "Google Compute Engine GKE configuration"
  describe command("gcloud beta --project=#{project_id} container clusters --zone=#{location} describe #{cluster_name} --format=json --format=\"json(nodePools[0].config.workloadMetadataConfig.nodeMetadata)\"") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "workload metada config" do
      it "is secure" do
        expect(data['nodePools'][0]["config"]["workloadMetadataConfig"]["nodeMetadata"]).to eq 'SECURE'
      end
    end
  end

  describe command("gcloud beta --project=#{project_id} container clusters --zone=#{location} describe #{cluster_name} --format=json --format=\"json(nodeConfig.workloadMetadataConfig)\"") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    describe "workload metada config" do
      it "is secure" do
        expect(data["nodeConfig"]["workloadMetadataConfig"]["nodeMetadata"]).to eq 'SECURE'
      end
    end
  end
end
