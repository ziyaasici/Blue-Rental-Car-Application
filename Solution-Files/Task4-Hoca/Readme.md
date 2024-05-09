Yapilanlar : 

    Jenkins Makina Uzerinde;
        - Repo clonlandi : git clone https://ziyaasici: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@github.com/ziyaasici/Blue-Rental-Car-Application.git
        - Kompose kurulumu
            - curl -L https://github.com/kubernetes/kompose/releases/download/v1.33.0/kompose-linux-amd64 -o kompose
            - chmod +x kompose
            - sudo mv ./kompose /usr/local/bin/kompose
            - kompose version
        - KubeCTL Kurulumu
            - curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
            - sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
            - kubectl version --client
        - 


