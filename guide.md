# Implementation Guide

## 1. Mục tiêu bài lab
- Sử dụng Terraform và Cloudformation để quản lý và triển khai hạ tầng AWS.
- Các dịch vụ cần triển khai dưới dạng modules bao gồm: VPC, Route Tables, NAT Gateway, EC2. 
- Đảm bảo bảo mật cho EC2 bằng cách thiết lập security groups.

## 2. Môi trường thực hành
- Hệ điều hành: Window 2011
- Các công cụ sử dụng: 
+ Terraform: version 1.15.5 (latest update since 08/06/2026)
+ AWS CLI

## 3. Quy tình triển khai
1. Chuẩn bị môi trường
- Cấu hình AWS CLI: 
`configure`
 * + Nhập các biến môi trường tương tự nhưu được yêu cầu vào terminal. [AWS Access Key ID, AWS Secret Access Key, Default region name, Default output format]
 * + Kiểm tra lại bằng câu lệnh `ắ sts get-caller-identity`
 * + Output sẽ là:
 ```json
 {                                                   
    "UserId": "AROAU6GD3NI6YW64J34AU:user4631317=23521554@gm.uit.edu.vn",
    "Account": "339713157693",
    "Arn": "arn:aws:sts::339713157693:assumed-role/voclabs/user4631317=23521554@gm.uit.edu.vn"
}
 ```

2. Cấu trúc thư mục
```text
terraform/
│
├── main.tf          # File cấu hình chính, nơi gọi và liên kết các module lại với nhau.
├── variables.tf     # Khai báo các biến đầu vào cho toàn bộ hạ tầng 
├── outputs.tf       # Định nghĩa các dữ liệu đầu ra cần hiển thị sau khi áp dụng cấu hình.
├── provider.tf      # Cấu hình nhà cung cấp đám mây (AWS) và phiên bản Terraform sử dụng.
│
└── modules/         # Thư mục chứa các thành phần hạ tầng có thể tái sử dụng.
    ├── vpc/         
    ├── sg/          
    ├── ec2/         
    └── nat/         
```
3. C�c bu?c tri?n khai c? th?
   - Bước 1: Triển khai VPC
   * + File main.tf
   ```bash
   # VPC
resource "aws_vpc" "this" {
  cidr_block = var.cidr

  tags = {
    Name = "demo-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "demo-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.private_subnet

  tags = {
    Name = "private-subnet"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "public-rt"
  }
}

# Route Internet for Public
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "private-rt"
  }
}

# Associate Private Subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
   ```
4. �p d?ng Terraform
   - `terraform init`
   - `terraform plan`
   - `terraform apply`

## 5. C?u h�nh v� tham s?
- Th�ng tin bi?n c?n c?u h�nh trong `variables.tf`.
- Gi� tr? m?u n?u c?n.

## 6. Ki?m th? v� x�c nh?n
- C�ch ki?m tra k?t qu? deploy d�ng.
- L?nh ho?c bu?c x�c th?c.

## 7. V?n d? d� g?p v� x? l�
- C�c l?i d� g?p khi tri?n khai.
- C�ch kh?c ph?c.

## 8. K?t lu?n
- T�m t?t k?t qu?.
- B�i h?c r�t ra.

## 9. Tham chi?u
- Link t�i li?u, b�i lab, tham kh?o b? sung.
