# TO DO
# Ajustar permissoes para acessos via Kubectl para usuario nomeado
<<<<<<< HEAD
#####
=======
##### code
>>>>>>> 440d73912167a19c2277c595c5042850f9c3d384
  kind: ConfigMap
  apiVersion: v1
  metadata:
    name: aws-auth
    namespace: kube-system
    uid: 568a221a-1fd8-4ad3-bdc6-844094edc09b
    resourceVersion: '39890'
    creationTimestamp: '2025-04-17T13:11:35Z'
    managedFields:
      - manager: vpcLambda
        operation: Update
        apiVersion: v1
        time: '2025-04-17T13:11:38Z'
        fieldsType: FieldsV1
        fieldsV1:
          f:data:
            .: {}
            f:mapRoles: {}
      - manager: Mozilla
        operation: Update
        apiVersion: v1
        time: '2025-04-17T16:57:52Z'
        fieldsType: FieldsV1
        fieldsV1:
          f:data:
            f:mapUsers: {}
  data:
    mapRoles: |
      - groups:
        - system:bootstrappers
        - system:nodes
        rolearn: arn:aws:iam::443370700365:role/blue-eks-node-group-20250417130352849400000009
        username: system:node:{{EC2PrivateDNSName}}
      - groups:
        - system:bootstrappers
        - system:nodes
        rolearn: arn:aws:iam::443370700365:role/green-eks-node-group-20250417130352079000000008
        username: system:node:{{EC2PrivateDNSName}}
    mapUsers: |
      - groups:
        - system:masters
        userarn: arn:aws:iam::443370700365:user/jeferson
        username: jeferson



<<<<<<< HEAD



=======
>>>>>>> 440d73912167a19c2277c595c5042850f9c3d384
attach ROLE IAM ao green-eks-node-group-20250421205138504200000008
e ao 
blue-eks-node-group-20250421205139223500000009 
AmazonEBSCSIDriverPolicy


<<<<<<< HEAD


=======
>>>>>>> 440d73912167a19c2277c595c5042850f9c3d384
### ajustar storage
instalar do helm 

helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
helm repo update

instalar

helm upgrade --install aws-ebs-csi-driver \
  aws-ebs-csi-driver/aws-ebs-csi-driver \
  --namespace kube-system


ver se roda
<<<<<<< HEAD
kubectl get pods -n kube-system | grep ebs
=======
kubectl get pods -n kube-system | grep ebs
>>>>>>> 440d73912167a19c2277c595c5042850f9c3d384
