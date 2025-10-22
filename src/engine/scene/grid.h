#pragma once

#include "utils/pch.h"

class CommandQueue;
class DescriptorHeap;
class Mesh;
class Pipeline;
class ConstantBuffer;

class Grid {
    public:
        Grid(
            ComPtr<ID3D12Device2> device,
            CommandQueue* commandQueue,
            DescriptorHeap* srvHeap
        );

        ~Grid() = default;

        void draw(ID3D12GraphicsCommandList* cmdList);

        void updateMVP(const XMMATRIX& viewProj);

    private:
        ComPtr<ID3D12Device2> device;
        std::unique_ptr<Mesh> mesh;
        std::unique_ptr<Pipeline> pipeline;
        std::unique_ptr<ConstantBuffer> mvpBuffer;
};